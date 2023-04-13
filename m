Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 8E6206E1797
	for <lists+linux-kernel@lfdr.de>; Fri, 14 Apr 2023 00:40:03 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229667AbjDMWkA (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 13 Apr 2023 18:40:00 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56796 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230309AbjDMWjv (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 13 Apr 2023 18:39:51 -0400
Received: from galois.linutronix.de (Galois.linutronix.de [IPv6:2a0a:51c0:0:12e:550::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8DF6EAD12
        for <linux-kernel@vger.kernel.org>; Thu, 13 Apr 2023 15:39:27 -0700 (PDT)
From:   Thomas Gleixner <tglx@linutronix.de>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020; t=1681425564;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=t8ZGlD5y99nuYbUdfAnl+Ad+d+jEX3P0YqKpyEIDTkY=;
        b=kCFnP/gR2ckV3MwhvCKxVuxjg7kgGhJtkVtTwrrLNp2noUT/3WzcI4shoylS5KNEvCC0Uc
        onBynsX+CiKPAY2LPfiMvSwuPwB+bzC063SuWRJiMCEsDLBp9o2jqZfRO7jlPU4FqWJDOT
        U+p/f5p5lUb2wYi1ZhlG2sXVO6oWGc9wxxcnD3BiqcfFTjcvZel3nzr1nOiOgi3Ae7ojF4
        1KcFwD7V4tvvF14V8AiDo2hFWhTEYPZ3dEqzXxwJ3uBqxFqqXC6O2bTLQ79qiQaPx0YRPo
        F975ChZt4wIPCrf0qyYs8xY8PlDEFXjce2PUXuFaJlPGoJISqopyCOdkU5E0MA==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020e; t=1681425564;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=t8ZGlD5y99nuYbUdfAnl+Ad+d+jEX3P0YqKpyEIDTkY=;
        b=nxk3GHauzC/2qJvc9brz80CR+DNVq3qcUW6CkrP5yKQIHd18BMyji1xs9VT4IkKQLkyBGy
        MVYcEqiN76A20hAA==
To:     Schspa Shi <schspa@gmail.com>
Cc:     longman@redhat.com, swboyd@chromium.org, linux@roeck-us.net,
        wuchi.zero@gmail.com, linux-kernel@vger.kernel.org
Subject: Re: [PATCH 2/2] debugobject: add unit test for static debug object
In-Reply-To: <m2a603onvq.fsf@gmail.com>
References: <20230303161906.831686-1-schspa@gmail.com>
 <20230303161906.831686-2-schspa@gmail.com> <m2sfdwnoi8.fsf@gmail.com>
 <87h6ub9a4w.ffs@tglx> <m2a603onvq.fsf@gmail.com>
Date:   Fri, 14 Apr 2023 00:39:23 +0200
Message-ID: <87edonz9t0.ffs@tglx>
MIME-Version: 1.0
Content-Type: text/plain
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,SPF_HELO_NONE,
        SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Mar 23 2023 at 16:44, Schspa Shi wrote:
> Thomas Gleixner <tglx@linutronix.de> writes:
>> On Thu, Mar 23 2023 at 11:16, Schspa Shi wrote:
>>> What do you think about this test case? Should we need it ? There are
>>> some platform compatibility issues here that need a little optimization.
>>
>> What does it buy over the existing self test. Nothing AFACIT aside of
>> extra code.
>>
>
> It checks the race of the is_static_object() call in the previous
> BUG. This test can used to make sure the new fix patch works. The
> existing self test have no ability to check this.

Sure it can somehow make sure that it works.

Don't misunderstand me. I'm all for self tests, but this one really
falls into the category of testing the obvious. There are tons of more
interesting places in the kernel which lack self tests than this
particular oddity which is well understood and more than unlikely to
come back.

That said, it would be valuable if you could add your Tested-by to the
final patch, which will be queued up soonish.

Thanks,

        tglx
