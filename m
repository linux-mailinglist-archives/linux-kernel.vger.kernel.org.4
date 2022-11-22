Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 570A9633E7E
	for <lists+linux-kernel@lfdr.de>; Tue, 22 Nov 2022 15:08:30 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233353AbiKVOI0 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 22 Nov 2022 09:08:26 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56362 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234036AbiKVOIC (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 22 Nov 2022 09:08:02 -0500
Received: from casper.infradead.org (casper.infradead.org [IPv6:2001:8b0:10b:1236::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 072BE1DA62
        for <linux-kernel@vger.kernel.org>; Tue, 22 Nov 2022 06:06:21 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=casper.20170209; h=In-Reply-To:Content-Type:MIME-Version:
        References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
        Content-Transfer-Encoding:Content-ID:Content-Description;
        bh=QDYcMUCtSl9YoPGZD4u9771L9C9DxrFPzpaFGh4a/sY=; b=S2eMx9WTdQC/VfiX5e0mcSjxxG
        xfBKbPLz0KGF59XtKywWJhTpsKBpwaBshAEx7ZMse9QFddFaCHdVPWu+P/Bu8AbsVJoaORKZJE0hw
        vlUkTeCPrOvNhMP62VF/cRKfF8iZM2qY2fOAVueMsXFF0NYL4V+gls7HIWF81h7Vc8sBGIrhhSFDW
        sJaEfPFVmw8Go2wT0KCYEUPdNjN5kJAXZCvK3ZspOBp8O4qTKO7j8dsdhOL1sWV8mOjOMMshik0be
        l8q88Wg4/aqM3hhxxxpPQWCiMB368jygTYvuew/5TB/9wZ5LmMlNM6ypRHJasGUHtw0fBVqCdbaQ2
        anwj+VAw==;
Received: from j130084.upc-j.chello.nl ([24.132.130.84] helo=noisy.programming.kicks-ass.net)
        by casper.infradead.org with esmtpsa (Exim 4.94.2 #2 (Red Hat Linux))
        id 1oxTuk-006QlR-CJ; Tue, 22 Nov 2022 14:06:18 +0000
Received: from hirez.programming.kicks-ass.net (hirez.programming.kicks-ass.net [192.168.1.225])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (4096 bits))
        (Client did not present a certificate)
        by noisy.programming.kicks-ass.net (Postfix) with ESMTPS id 5BFCB300445;
        Tue, 22 Nov 2022 15:06:11 +0100 (CET)
Received: by hirez.programming.kicks-ass.net (Postfix, from userid 1000)
        id 4A7332077D3E6; Tue, 22 Nov 2022 15:06:11 +0100 (CET)
Date:   Tue, 22 Nov 2022 15:06:11 +0100
From:   Peter Zijlstra <peterz@infradead.org>
To:     wangbiao3@xiaomi.com
Cc:     mingo@redhat.com, juri.lelli@redhat.com,
        vincent.guittot@linaro.org, brauner@kernel.org, bsegall@google.com,
        linux-kernel@vger.kernel.org, wenjieli@qti.qualcomm.com,
        chenguanyou@xiaomi.com, Will Deacon <will@kernel.org>,
        Waiman Long <longman@redhat.com>
Subject: Re: [PATCH 1/1] sched: fix user_mask double free
Message-ID: <Y3zXU8SB4rnKQqFZ@hirez.programming.kicks-ass.net>
References: <cover.1669020858.git.wangbiao3@xiaomi.com>
 <b8970a530d420109ee9fe0b268e097fb839211b0.1669020858.git.wangbiao3@xiaomi.com>
 <Y3zXDZeTUgDz2hJ8@hirez.programming.kicks-ass.net>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <Y3zXDZeTUgDz2hJ8@hirez.programming.kicks-ass.net>
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,SPF_HELO_NONE,
        SPF_NONE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Nov 22, 2022 at 03:05:01PM +0100, Peter Zijlstra wrote:
> 
> So you failed:
> 

> > #/******?????????????????????????????????????????????????????????????????????????????????????????????????????????????????????????????????????????????????????????????????????????????????????????????????????????????????????????????????????? This e-mail and its attachments contain confidential information from XIAOMI, which is intended only for the person or entity whose address is listed above. Any use of the information contained herein in any way (including, but not limited to, total or partial disclosure, reproduction, or dissemination) by persons other than the intended recipient(s) is prohibited. If you receive this e-mail in error, please notify the sender by phone or email immediately and delete it!******/#

Also, that ^ is super fail, you're sending this to a public list. Please
tell your (IT) manager it makes your corporation look like an idiot.
