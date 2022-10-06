Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 219015F641F
	for <lists+linux-kernel@lfdr.de>; Thu,  6 Oct 2022 12:07:44 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230464AbiJFKHl (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 6 Oct 2022 06:07:41 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59670 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229665AbiJFKHj (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 6 Oct 2022 06:07:39 -0400
Received: from casper.infradead.org (casper.infradead.org [IPv6:2001:8b0:10b:1236::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 78B5F2E6AB
        for <linux-kernel@vger.kernel.org>; Thu,  6 Oct 2022 03:07:38 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=casper.20170209; h=In-Reply-To:Content-Type:MIME-Version:
        References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
        Content-Transfer-Encoding:Content-ID:Content-Description;
        bh=IRFKKFfGjKSiTQ/3UYoPOnI3CZ6GteQ0lj3QjnHUH00=; b=ECYTTWjoD1Oyrixz7rI8VBEBxu
        /xPREE0ttqt2vVr/oThDOVsvCmcTmsSrn6Xv3CFHTXaQyuVzOa7iORnzTdQfkOpfejHEFfF/WxreE
        mn2sFEMdBLvPqX+y69JmhiaoVLYgxyI6b7vf4qptu1O5yVUtvOPRYj8w3y50ajdarIx+/GAZmLMT7
        gi+3Jani6pKYhVIOfP+APLVNw/DjBKOSdAFVxVF7iSEZAentco59vPN7Lk/IFU5hegLZUo1NwVgGW
        PHQlbJJqVE4GKc5jfWm7e8sW5tKzded4i7hUtFrCrB6OuugoZCnzsWtnTfR4pSGSVIEN4DKQe9cfA
        iHuZMl7w==;
Received: from j130084.upc-j.chello.nl ([24.132.130.84] helo=noisy.programming.kicks-ass.net)
        by casper.infradead.org with esmtpsa (Exim 4.94.2 #2 (Red Hat Linux))
        id 1ogNme-0013bf-2O; Thu, 06 Oct 2022 10:07:18 +0000
Received: from hirez.programming.kicks-ass.net (hirez.programming.kicks-ass.net [192.168.1.225])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
        (Client did not present a certificate)
        by noisy.programming.kicks-ass.net (Postfix) with ESMTPS id 8D4AD30007E;
        Thu,  6 Oct 2022 12:07:10 +0200 (CEST)
Received: by hirez.programming.kicks-ass.net (Postfix, from userid 1000)
        id 61536205FDD2D; Thu,  6 Oct 2022 12:07:10 +0200 (CEST)
Date:   Thu, 6 Oct 2022 12:07:10 +0200
From:   Peter Zijlstra <peterz@infradead.org>
To:     Juri Lelli <juri.lelli@redhat.com>
Cc:     Connor O'Brien <connoro@google.com>, linux-kernel@vger.kernel.org,
        kernel-team@android.com, John Stultz <jstultz@google.com>,
        Joel Fernandes <joelaf@google.com>,
        Qais Yousef <qais.yousef@arm.com>,
        Ingo Molnar <mingo@redhat.com>,
        Vincent Guittot <vincent.guittot@linaro.org>,
        Dietmar Eggemann <dietmar.eggemann@arm.com>,
        Steven Rostedt <rostedt@goodmis.org>,
        Ben Segall <bsegall@google.com>, Mel Gorman <mgorman@suse.de>,
        Daniel Bristot de Oliveira <bristot@redhat.com>,
        Valentin Schneider <vschneid@redhat.com>,
        Will Deacon <will@kernel.org>,
        Waiman Long <longman@redhat.com>,
        Boqun Feng <boqun.feng@gmail.com>,
        "Paul E . McKenney" <paulmck@kernel.org>
Subject: Re: [RFC PATCH 00/11] Reviving the Proxy Execution Series
Message-ID: <Yz6ozjNES7ioCq8C@hirez.programming.kicks-ass.net>
References: <20221003214501.2050087-1-connoro@google.com>
 <Yz6nA4rY39dB4Wke@localhost.localdomain>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <Yz6nA4rY39dB4Wke@localhost.localdomain>
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,SPF_HELO_NONE,
        SPF_NONE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Oct 06, 2022 at 11:59:31AM +0200, Juri Lelli wrote:

> I think another fundamental question I'm not sure we spent much time on
> yet is how to deal with rtmutexes.

Delete them ;-) If PE works, they have no value left.
