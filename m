Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 3B0DC6EEC46
	for <lists+linux-kernel@lfdr.de>; Wed, 26 Apr 2023 04:15:34 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S239052AbjDZCPb (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 25 Apr 2023 22:15:31 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59992 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S238460AbjDZCP3 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 25 Apr 2023 22:15:29 -0400
Received: from mail-qv1-xf2f.google.com (mail-qv1-xf2f.google.com [IPv6:2607:f8b0:4864:20::f2f])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C62B0618E
        for <linux-kernel@vger.kernel.org>; Tue, 25 Apr 2023 19:15:27 -0700 (PDT)
Received: by mail-qv1-xf2f.google.com with SMTP id 6a1803df08f44-5ef54bcded4so30350326d6.1
        for <linux-kernel@vger.kernel.org>; Tue, 25 Apr 2023 19:15:27 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=joelfernandes.org; s=google; t=1682475327; x=1685067327;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=jGc47UmShwVrvDYZPpGcnQwNYLvIbd7qZ14xZo9khvU=;
        b=Q1fA8n97qoplxDSqa8wI8dtHEu1b9yHDm+d49HtS9Hw7PILZx9lDF0GpjgZTSsklU4
         d1DI5wPp7hQ0hOPbiY8rDzmBs3U2TsTfCBzQ/ibSfH+sv6uza0b6iYchK17Mo2UyP17l
         dO5hILr4oMBKVAYcmJiiJpCtsCUJqNLkj0Bdk=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1682475327; x=1685067327;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=jGc47UmShwVrvDYZPpGcnQwNYLvIbd7qZ14xZo9khvU=;
        b=TxMXanPSFUnZotTfVmX83wdjtEsKQQH93ZagIsK6bFuf7GgmcIgEyu2KU47Ox+Ms2B
         MzMATuSNw1oBE8wgQsiyQh3gmo664sdoaVaM1zKLk+CdOwR0udtmh15SwOLTCL44Ec0+
         c7PqrDSh4REzIPeppRFMcSYLOgO/O/fEpc4/y6dMKbqjbE49M/RmzmR0kWK1it7aGVkZ
         S9Is8BBQa6gxXKQ0zpqpC/E7gd8v1m2B1Pa7Ap5CjxPgyVuuS3tNn4jFWyxTI5wq0zmu
         o7FZ/9UnR2QrAzJsbXDwJHRQ/aG0QZeRrCgqNnCmIPzD+CIxwG8pbLTBvSeGi6dCWW1i
         dj0g==
X-Gm-Message-State: AAQBX9cMuS7ycs3ureocU0lOvrhQxEsQJzlr6nANneQlQLqX1pHZZ6if
        5E9Fh/1BLB9/XpmEd6WrDMOhTc010tBG5kuDLdA=
X-Google-Smtp-Source: AKy350b9uSUMPSCwybpYqSUcr8gjirWn9Qm4JhzaIyDtDY7ICUyQYmQeurkjgnSCeAYc5LUWkrzvdw==
X-Received: by 2002:a05:6214:2305:b0:5ef:5e1b:a365 with SMTP id gc5-20020a056214230500b005ef5e1ba365mr29059934qvb.10.1682475326878;
        Tue, 25 Apr 2023 19:15:26 -0700 (PDT)
Received: from localhost (129.239.188.35.bc.googleusercontent.com. [35.188.239.129])
        by smtp.gmail.com with ESMTPSA id b9-20020a0ccd09000000b005e5b2c560d0sm4497149qvm.7.2023.04.25.19.15.26
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 25 Apr 2023 19:15:26 -0700 (PDT)
Date:   Wed, 26 Apr 2023 02:15:25 +0000
From:   Joel Fernandes <joel@joelfernandes.org>
To:     Zhouyi Zhou <zhouzhouyi@gmail.com>
Cc:     Christophe Leroy <christophe.leroy@csgroup.eu>,
        Peter Zijlstra <peterz@infradead.org>,
        Boqun Feng <boqun.feng@gmail.com>,
        Segher Boessenkool <segher@kernel.crashing.org>,
        Michael Ellerman <mpe@ellerman.id.au>,
        linuxppc-dev <linuxppc-dev@lists.ozlabs.org>,
        rcu <rcu@vger.kernel.org>,
        linux-kernel <linux-kernel@vger.kernel.org>,
        "lance@osuosl.org" <lance@osuosl.org>,
        "Paul E. McKenney" <paulmck@kernel.org>
Subject: Re: BUG : PowerPC RCU: torture test failed with __stack_chk_fail
Message-ID: <20230426021525.GA2171827@google.com>
References: <20230424151351.GP19790@gate.crashing.org>
 <ZEagN1jJwg+rUzX4@boqun-archlinux>
 <CAEXW_YRfetnhgCw5OgnwhgZF_U+UkHN=uy=L8ovGLqn1UCtfTg@mail.gmail.com>
 <20230425101324.GD1331236@hirez.programming.kicks-ass.net>
 <CAABZP2ypJ98T3XAqPnLrxxzrYckSQ6sn3woEmpigQ+cRRaw=Zw@mail.gmail.com>
 <CAEXW_YQEarLt7YGQZdwmcSyZcGRCGKf89ovxjQdXBO-TgXAk-w@mail.gmail.com>
 <528b2adc-9955-5545-9e9d-affd1f935838@csgroup.eu>
 <CAABZP2zW7aTPChjvZMA1bECdOdFUdTd-q+vEJXJnH2zPU+uR8A@mail.gmail.com>
 <CAEXW_YQJowYrF2A=f2NOKNNjL6qZH6LzghBxt7VnJFgg-i1zgg@mail.gmail.com>
 <CAABZP2w8eDSRXCoLiWGjGtz6VifPfaaF=Mje7Y8aXjugy-vNkA@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CAABZP2w8eDSRXCoLiWGjGtz6VifPfaaF=Mje7Y8aXjugy-vNkA@mail.gmail.com>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED
        autolearn=unavailable autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Zhouyi,

On Wed, Apr 26, 2023 at 09:31:17AM +0800, Zhouyi Zhou wrote:
[..]
> Joel makes the learning process easier for me, indeed!

I know that feeling being a learner myself ;-)

> One question I have tried very hard to understand, but still confused.
> for now, I know
> r13 is fixed, but r1 is not, why "r9,40(r1)"'s 40(r1) can be assumed
> to be equal to 3192(r10).

First you have to I guess read up a bit about stack canaries. Google for
"gcc stack protector" and "gcc stack canaries", and the look for basics of
"buffer overflow attacks". That'll explain the concept of stack guards etc
(Sorry if this is too obvious but I did not know how much you knew about it
already).

40(r1) is where the canary was stored. In the beginning of the function, you
have this:

c000000000226d58:	78 0c 2d e9 	ld      r9,3192(r13)
c000000000226d5c:	28 00 21 f9 	std     r9,40(r1)

r1 is your stack pointer. 3192(r13) is the canary value.

40(r1) is where the canary is stored for later comparison.

r1 should not change through out the function I believe, because otherwise
you don't know where the stack frame is, right?

Later you have this stuff before the function returns which gcc presumably
did due to optimization. That mr means move register and is where the caching
of r13 to r10 happens that Boqun pointed.

c000000000226eb4:	78 6b aa 7d 	mr      r10,r13
[...]
and then the canary comparison happens:

c000000000226ed8:	28 00 21 e9 	ld      r9,40(r1)
c000000000226edc:	78 0c 4a e9 	ld      r10,3192(r10)
c000000000226ee0:	79 52 29 7d 	xor.    r9,r9,r10
c000000000226ee4:	00 00 40 39 	li      r10,0
c000000000226ee8:	b8 03 82 40 	bne     c0000000002272a0 <srcu_gp_start_if_needed+0x5a0>

So looks like for this to blow up, the preemption/migration has to happen
precisely between the mr doing the caching, and the xor doing the comparison,
since that's when the r10 will be stale.

thanks,

 - Joel

