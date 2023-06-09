Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id CDB74729265
	for <lists+linux-kernel@lfdr.de>; Fri,  9 Jun 2023 10:15:14 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S238369AbjFIIPE (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 9 Jun 2023 04:15:04 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49698 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S240172AbjFIIPB (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 9 Jun 2023 04:15:01 -0400
Received: from casper.infradead.org (casper.infradead.org [IPv6:2001:8b0:10b:1236::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6F8C51FEC;
        Fri,  9 Jun 2023 01:15:00 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=casper.20170209; h=In-Reply-To:Content-Transfer-Encoding:
        Content-Type:MIME-Version:References:Message-ID:Subject:Cc:To:From:Date:
        Sender:Reply-To:Content-ID:Content-Description;
        bh=+cwenPjityAug3WNzlNqZYfDn0z0LVC2siDeul5t8mY=; b=FHSTN20504TR15rO6GosZftBSu
        zs4/8pgg8bMheZAJHp/mN5JI7Xxu29i2YRxizdaaKCDLOGZOePbg8ZJ61mQLQdItOg+wL8yZb1178
        QwNxoUU6gwGdMsLQnsUyfq4Fj+Yb8ngNWSsEhg6Pa4vY3WiTZuo+tlHSiZvEgvndGshzcyVXPpWs1
        sTSFVahZEj1EIfwzVMg5Gop2HYGug8u/I2tXN3ml07pOq9ZK+MJKO04wJ4SBblFVRf1o7r1p5W8PB
        41rheKlPkUk3Oo4I1JbZUfVauVggwIqZ0DigHG2KIw02y7hdsX9fKsB9rIeHWUYKS3X9pFmiii13w
        XC77uYPw==;
Received: from j130084.upc-j.chello.nl ([24.132.130.84] helo=noisy.programming.kicks-ass.net)
        by casper.infradead.org with esmtpsa (Exim 4.94.2 #2 (Red Hat Linux))
        id 1q7XGV-00GLUF-Re; Fri, 09 Jun 2023 08:14:35 +0000
Received: from hirez.programming.kicks-ass.net (hirez.programming.kicks-ass.net [192.168.1.225])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
        (Client did not present a certificate)
        by noisy.programming.kicks-ass.net (Postfix) with ESMTPS id F30D4300155;
        Fri,  9 Jun 2023 10:14:32 +0200 (CEST)
Received: by hirez.programming.kicks-ass.net (Postfix, from userid 1000)
        id CDDA7241717B3; Fri,  9 Jun 2023 10:14:32 +0200 (CEST)
Date:   Fri, 9 Jun 2023 10:14:32 +0200
From:   Peter Zijlstra <peterz@infradead.org>
To:     Linus Torvalds <torvalds@linux-foundation.org>
Cc:     keescook@chromium.org, gregkh@linuxfoundation.org,
        pbonzini@redhat.com, linux-kernel@vger.kernel.org,
        ojeda@kernel.org, ndesaulniers@google.com, mingo@redhat.com,
        will@kernel.org, longman@redhat.com, boqun.feng@gmail.com,
        juri.lelli@redhat.com, vincent.guittot@linaro.org,
        dietmar.eggemann@arm.com, rostedt@goodmis.org, bsegall@google.com,
        mgorman@suse.de, bristot@redhat.com, vschneid@redhat.com,
        paulmck@kernel.org, frederic@kernel.org, quic_neeraju@quicinc.com,
        joel@joelfernandes.org, josh@joshtriplett.org,
        mathieu.desnoyers@efficios.com, jiangshanlai@gmail.com,
        rcu@vger.kernel.org, tj@kernel.org, tglx@linutronix.de,
        linux-toolchains@vger.kernel.org
Subject: Re: [PATCH v2 0/2] Lock and Pointer guards
Message-ID: <20230609081432.GB1039598@hirez.programming.kicks-ass.net>
References: <CAHk-=wi-RyoUhbChiVaJZoZXheAwnJ7OO=Gxe85BkPAd93TwDA@mail.gmail.com>
 <20230606134005.GE905437@hirez.programming.kicks-ass.net>
 <CAHk-=wgQ5m+SnWTYGHu0JgYXTk2dkGF+msX=ARfYoo3t1_fX9g@mail.gmail.com>
 <20230606180806.GA942082@hirez.programming.kicks-ass.net>
 <CAHk-=wgXN1YxGMUFeuC135aeUvqduF8zJJiZZingzS1Pao5h0A@mail.gmail.com>
 <20230607094101.GA964354@hirez.programming.kicks-ass.net>
 <20230608085248.GA1002251@hirez.programming.kicks-ass.net>
 <CAHk-=wj-BGgTF0YgY+L7_G8Jb0UO38Cd8dwrfMqFMEh93B3D7g@mail.gmail.com>
 <20230608200618.GA1020752@hirez.programming.kicks-ass.net>
 <CAHk-=wjcXuZ91WkKv0fuBcm+w7y=y=fNzW9EXfnYYSCFvuyhdA@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <CAHk-=wjcXuZ91WkKv0fuBcm+w7y=y=fNzW9EXfnYYSCFvuyhdA@mail.gmail.com>
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,SPF_HELO_NONE,
        SPF_NONE,T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Jun 08, 2023 at 07:25:27PM -0700, Linus Torvalds wrote:
> On Thu, Jun 8, 2023 at 1:06 PM Peter Zijlstra <peterz@infradead.org> wrote:
> >
> >         struct obj *p __free(kfree) = kmalloc(...);
> 
> Yeah, the above actually looks really good to me - I like the naming
> here, and the use looks very logical to me.
> 
> Of course, maybe once I see the patches that use this I go "uhh", but
> at least for now I think you've hit on a rather legible syntax.
> 
> I'm still a bit unsure of the "no_free_ptr(p)" naming, but at least
> it's pretty clear about what it does.
> 
> So my only worry is that it's not pretty and to the point like your
> "__free(kfree)" syntax.
> 
> But it feels workable and not misleading, so unless somebody can come
> up with a better name, I think it's ok.

#define return_ptr(p) \
	return no_free_ptr(p)


	struct obj *p __free(kfree) = kmalloc(...);
	if (!p)
		return ERR_PTR(-ENOMEM);

	...

	return_ptr(p);

?

