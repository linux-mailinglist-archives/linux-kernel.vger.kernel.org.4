Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 877E05FD78C
	for <lists+linux-kernel@lfdr.de>; Thu, 13 Oct 2022 12:03:29 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229651AbiJMKDU (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 13 Oct 2022 06:03:20 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36768 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229843AbiJMKDD (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 13 Oct 2022 06:03:03 -0400
Received: from casper.infradead.org (casper.infradead.org [IPv6:2001:8b0:10b:1236::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id CCD0A27FF3
        for <linux-kernel@vger.kernel.org>; Thu, 13 Oct 2022 03:02:43 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=casper.20170209; h=In-Reply-To:Content-Type:MIME-Version:
        References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
        Content-Transfer-Encoding:Content-ID:Content-Description;
        bh=UlXZeJ+CQj5Nn1aM9o6JmHtV+nPSpnbFh7Jiz8rjgh4=; b=flmBrJxjy1NAreiMlz0jLHDSRO
        1uyYTeEMLBcUBunMcicrfe5JCFQAJ7BkNDiztuWylCYYaIzjNrZEfrGozQZ3JjNxYqOTXu1HPYLkM
        xBE3q1wvcrs6S2D4moWVGszFjweS6ensaNy56y+L5tLCVS0d+yrJCCk+coM/qfoQygbYixHsJeDNy
        o65CiUuhHuBGWJixUb18ICuWvLO8V72cvnokN1m2uHNC3HI1m9/yMKbaOw+FsjLLgsKGnyMd1U5b0
        XF5aCrDaKBDseEeK61sutWcbYiPxIkA2KrgpWfPT7xg01RWxXK/b55Et+pO82a3OIkZJRvMLG+6Zr
        g9LiJtSw==;
Received: from j130084.upc-j.chello.nl ([24.132.130.84] helo=noisy.programming.kicks-ass.net)
        by casper.infradead.org with esmtpsa (Exim 4.94.2 #2 (Red Hat Linux))
        id 1oiv2d-006ce4-KJ; Thu, 13 Oct 2022 10:02:15 +0000
Received: from hirez.programming.kicks-ass.net (hirez.programming.kicks-ass.net [192.168.1.225])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
        (Client did not present a certificate)
        by noisy.programming.kicks-ass.net (Postfix) with ESMTPS id 6CFC73000E3;
        Thu, 13 Oct 2022 12:02:09 +0200 (CEST)
Received: by hirez.programming.kicks-ass.net (Postfix, from userid 1000)
        id 416E62BB91E22; Thu, 13 Oct 2022 12:02:09 +0200 (CEST)
Date:   Thu, 13 Oct 2022 12:02:09 +0200
From:   Peter Zijlstra <peterz@infradead.org>
To:     Waiman Long <longman@redhat.com>
Cc:     Ingo Molnar <mingo@redhat.com>, Will Deacon <will@kernel.org>,
        Boqun Feng <boqun.feng@gmail.com>,
        linux-kernel@vger.kernel.org, john.p.donnelly@oracle.com,
        Hillf Danton <hdanton@sina.com>,
        Mukesh Ojha <quic_mojha@quicinc.com>,
        Ting11 Wang =?utf-8?B?546L5am3?= <wangting11@xiaomi.com>
Subject: Re: [PATCH v2 1/2] locking/rwsem: Prevent non-first waiter from
 spinning in down_write() slowpath
Message-ID: <Y0fiIdxA+Jip1vve@hirez.programming.kicks-ass.net>
References: <20221012133333.1265281-1-longman@redhat.com>
 <20221012133333.1265281-2-longman@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20221012133333.1265281-2-longman@redhat.com>
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,SPF_HELO_NONE,
        SPF_NONE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Oct 12, 2022 at 09:33:32AM -0400, Waiman Long wrote:
> A non-first waiter can potentially spin in the for loop of
> rwsem_down_write_slowpath() without sleeping but fail to acquire the
> lock even if the rwsem is free if the following sequence happens:
> 
>   Non-first waiter       First waiter      Lock holder
>   ----------------       ------------      -----------
>   Acquire wait_lock
>   rwsem_try_write_lock():
>     Set handoff bit if RT or
>       wait too long
>     Set waiter->handoff_set
>   Release wait_lock
>                          Acquire wait_lock
>                          Inherit waiter->handoff_set
>                          Release wait_lock
> 					   Clear owner
>                                            Release lock
>   if (waiter.handoff_set) {
>     rwsem_spin_on_owner(();
>     if (OWNER_NULL)
>       goto trylock_again;
>   }
>   trylock_again:
>   Acquire wait_lock
>   rwsem_try_write_lock():
>      if (first->handoff_set && (waiter != first))
>      	return false;
>   Release wait_lock
> 
> It is especially problematic if the non-first waiter is an RT task and
> it is running on the same CPU as the first waiter as this can lead to
> live lock.
> 

So why not do a better handoff? Specifically, have the owner set owner
to first-waiter instead of NULL ? (like the normal mutex code)
