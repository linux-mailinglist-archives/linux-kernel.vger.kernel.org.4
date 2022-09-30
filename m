Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 3768E5F091C
	for <lists+linux-kernel@lfdr.de>; Fri, 30 Sep 2022 12:27:44 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232526AbiI3K1k (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 30 Sep 2022 06:27:40 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42786 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232465AbiI3KZE (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 30 Sep 2022 06:25:04 -0400
Received: from mail.skyhub.de (mail.skyhub.de [5.9.137.197])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1F3AE1DA50
        for <linux-kernel@vger.kernel.org>; Fri, 30 Sep 2022 03:19:49 -0700 (PDT)
Received: from zn.tnic (p200300ea9733e70a329c23fffea6a903.dip0.t-ipconnect.de [IPv6:2003:ea:9733:e70a:329c:23ff:fea6:a903])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.skyhub.de (SuperMail on ZX Spectrum 128k) with ESMTPSA id 28F5A1EC0666;
        Fri, 30 Sep 2022 12:19:39 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=alien8.de; s=dkim;
        t=1664533179;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:in-reply-to:in-reply-to:  references:references;
        bh=vjh05+Oz5jvzAv0RWE+u30Ynr1Qi+k7xCnkqZ2jc79Q=;
        b=P9OBFuoPmlTmSmvrgF7P3lz6+At9w+KEXr8JmOxZk9oOZxuoMD/99GP5EfKpQrbLIPPHg1
        iQuDH+MloVpy/yfk9+lQd4Gvr+he3e4J6bMmVgBfZOdHgCJwBWhfPQ3AW+tb8UtzNM3csk
        6NZ0G2UdTTgX6aLw9IHgyeQmkVxF0mY=
Date:   Fri, 30 Sep 2022 12:19:34 +0200
From:   Borislav Petkov <bp@alien8.de>
To:     "Paul E. McKenney" <paulmck@kernel.org>,
        Peter Zijlstra <peterz@infradead.org>
Cc:     x86-ml <x86@kernel.org>, lkml <linux-kernel@vger.kernel.org>
Subject: Re: INFO: task rcu_gp:3 blocked for more than 122 seconds.
Message-ID: <YzbCtvNWue+qUnT0@zn.tnic>
References: <YzVkyxSjifFghj8H@zn.tnic>
 <20220929153722.GG4196@paulmck-ThinkPad-P17-Gen-1>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20220929153722.GG4196@paulmck-ThinkPad-P17-Gen-1>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,SPF_HELO_NONE,SPF_PASS
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Sep 29, 2022 at 08:37:22AM -0700, Paul E. McKenney wrote:
> As discussed on IRC, I got nuttin' on this one.  Looks like an RCU
> expedited grace period is stuck waiting for its workqueue kthread, and
> that this workqueue kthread is stuck for some reason.

Yeah, it is not that easy to repro - I need to wait a couple of minutes
after it boots. Look at the timestamps:

[  249.149378] INFO: task rcu_gp:3 blocked for more than 122 seconds.
^^^^^^^^^^^^^^

But it looks like sched/core is the culprit because merging it into
Linus master triggers it.

Lemme bisect that.

Stay tuned.

-- 
Regards/Gruss,
    Boris.

https://people.kernel.org/tglx/notes-about-netiquette
