Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 1CC4F6FFBD7
	for <lists+linux-kernel@lfdr.de>; Thu, 11 May 2023 23:26:38 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S239214AbjEKV0g (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 11 May 2023 17:26:36 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35514 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232437AbjEKV0e (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 11 May 2023 17:26:34 -0400
Received: from desiato.infradead.org (desiato.infradead.org [IPv6:2001:8b0:10b:1:d65d:64ff:fe57:4e05])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4AC696587
        for <linux-kernel@vger.kernel.org>; Thu, 11 May 2023 14:26:31 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=desiato.20200630; h=In-Reply-To:Content-Type:MIME-Version:
        References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
        Content-Transfer-Encoding:Content-ID:Content-Description;
        bh=m7d/EZDyz9vAqfe7UDdO6jyEpmZlnIBccJBZScC5AWI=; b=S2ppX/Xxbfve592D3dMjbCBJSF
        gSdEmibX40/741Jr5RvFPh+1V8ko1aTx82h7UobgaAsWo+o8+QB9q64t1gN5XH5n9bMz49tKzV8Wb
        kb84+JHGT0Vb9UtLDE9S4yA8SyL83NB0vPUOYScL/plE8oxl2utFc+ajqk8JUZrk9XLiapjnHW8xW
        zvUqpkiGUQ8VhY94RaHQ7LTzV/6dSAuGssHc436eHtJtQCEo/HjkNfazffF5gYP5UsSggP1o6SMIl
        BbINJ/iX/RHlVLPRlkE6XBPYDXORYG1cYHJqa9z9g0HrpD2iSB/2vuP9NXZ3ukhC9+dQguxM5pDRJ
        NvC0guvw==;
Received: from j130084.upc-j.chello.nl ([24.132.130.84] helo=noisy.programming.kicks-ass.net)
        by desiato.infradead.org with esmtpsa (Exim 4.96 #2 (Red Hat Linux))
        id 1pxDnc-008Og4-2g;
        Thu, 11 May 2023 21:26:11 +0000
Received: from hirez.programming.kicks-ass.net (hirez.programming.kicks-ass.net [192.168.1.225])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (4096 bits))
        (Client did not present a certificate)
        by noisy.programming.kicks-ass.net (Postfix) with ESMTPS id 28E27300244;
        Thu, 11 May 2023 23:26:07 +0200 (CEST)
Received: by hirez.programming.kicks-ass.net (Postfix, from userid 1000)
        id 0780124829418; Thu, 11 May 2023 23:26:07 +0200 (CEST)
Date:   Thu, 11 May 2023 23:26:06 +0200
From:   Peter Zijlstra <peterz@infradead.org>
To:     Tejun Heo <tj@kernel.org>
Cc:     jiangshanlai@gmail.com, torvalds@linux-foundation.org,
        linux-kernel@vger.kernel.org, kernel-team@meta.com
Subject: Re: [PATCH 6/7] workqueue: Report work funcs that trigger automatic
 CPU_INTENSIVE mechanism
Message-ID: <20230511212606.GI2296992@hirez.programming.kicks-ass.net>
References: <20230511181931.869812-1-tj@kernel.org>
 <20230511181931.869812-7-tj@kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20230511181931.869812-7-tj@kernel.org>
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,SPF_HELO_NONE,
        SPF_NONE,T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, May 11, 2023 at 08:19:30AM -1000, Tejun Heo wrote:
> Workqueue now automatically marks per-cpu work items that hog CPU for too
> long as CPU_INTENSIVE, which excludes them from concurrency management and
> prevents stalling other concurrency-managed work items. If a work function
> keeps running over the thershold, it likely needs to be switched to use an
> unbound workqueue.
> 
> This patch adds a debug mechanism which tracks the work functions which
> trigger the automatic CPU_INTENSIVE mechanism and report them using
> pr_warn() with exponential backoff.
> 
> Signed-off-by: Tejun Heo <tj@kernel.org>
> Suggested-by: Peter Zijlstra <peterz@infradead.org>

I did do wonder why you chose for external storage for this -- I figured
it was to keep the cost down since it shouldn't really be happening, so
storage in the normal data structures is a waste etc..?

Otherwise seems fine; thanks!
