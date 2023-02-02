Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id E27D96876FE
	for <lists+linux-kernel@lfdr.de>; Thu,  2 Feb 2023 09:07:44 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232000AbjBBIHl (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 2 Feb 2023 03:07:41 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58380 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230463AbjBBIHh (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 2 Feb 2023 03:07:37 -0500
Received: from galois.linutronix.de (unknown [IPv6:2a0a:51c0:0:12e:550::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 108DA82415
        for <linux-kernel@vger.kernel.org>; Thu,  2 Feb 2023 00:07:35 -0800 (PST)
From:   Thomas Gleixner <tglx@linutronix.de>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020; t=1675325248;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=mh4N/SdxXTwcPZiuYuNBnIzmFadHfyL8FapC6uPyVlo=;
        b=i+39z7vBmjCN1863SvUSp353z/Cy5UWC5Car3YT72rV00MmJdNIyMYqqDtHtvNifKKLvWu
        UkKRVYrrBahPxzMj4dg3bvfdF0DTHAYaWj+SHYqt7u9+kUJzN021NF51MdmEFIYjsUofjx
        et5ZD1iQEl5/oON/e2s+Lm55pdJ6yHLnldvJYqjDlZGsJ1DuBIPKxhHsGLk0Tu+2nQ5kZo
        8LmHumQIBZTmk+ssl+ndsvuui0ObLG9baVzfgWV3Onj9Et+DQ3y27z4rRT2xDHDTKn3Bx1
        u1tld7oPTcWqg4Kj1S7I+2XSXDjsFJC4bp++FYUw/3DQ7vKSjrceuRZBoczmFw==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020e; t=1675325248;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=mh4N/SdxXTwcPZiuYuNBnIzmFadHfyL8FapC6uPyVlo=;
        b=sbrVBWGBhcuYDo3oPFy7IyL5UXFInVYUZpZqd/+Osq3QBEYUliuvClaChCJyLKMZscU9SU
        W0uBGu+i0RF+PDAQ==
To:     Wander Lairson Costa <wander@redhat.com>
Cc:     Peter Zijlstra <peterz@infradead.org>,
        Ingo Molnar <mingo@redhat.com>, Will Deacon <will@kernel.org>,
        Waiman Long <longman@redhat.com>,
        Boqun Feng <boqun.feng@gmail.com>,
        "open list:LOCKING PRIMITIVES" <linux-kernel@vger.kernel.org>,
        Sebastian Andrzej Siewior <bigeasy@linutronix.de>
Subject: Re: [PATCH] rtmutex: ensure we wake up the top waiter
In-Reply-To: <20230131175350.s7eiz55fozlhaegh@fedora>
References: <20230117172649.52465-1-wander@redhat.com> <875yd4k8qd.ffs@tglx>
 <CAAq0SUkN38V00HqV3Hk3ee_-=vfkKxG9xtR3n=4gAT+zCs+=Zg@mail.gmail.com>
 <87fsc6i6ud.ffs@tglx>
 <CAAq0SU=FmkSyS=-SQJBoHYEtZExK3Qn9Wqcn-c+BnmfVeO3q6g@mail.gmail.com>
 <20230131175350.s7eiz55fozlhaegh@fedora>
Date:   Thu, 02 Feb 2023 08:48:48 +0100
Message-ID: <87k010zevz.ffs@tglx>
MIME-Version: 1.0
Content-Type: text/plain
X-Spam-Status: No, score=-4.0 required=5.0 tests=BAYES_00,DKIM_INVALID,
        DKIM_SIGNED,MAY_BE_FORGED,NO_DNS_FOR_FROM,RCVD_IN_DNSWL_MED,
        T_SPF_HELO_TEMPERROR,T_SPF_TEMPERROR autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Jan 31 2023 at 14:53, Wander Lairson Costa wrote:
> On Tue, Jan 31, 2023 at 02:46:19PM -0300, Wander Lairson Costa wrote:
>> > If you have traces which show the sequence of lock events leading to
>> > this problem, then you should be able to decode the scenario. If you
>> > fail to extract the information, then please provide the traces so we
>> > can stare at them.
>> >
>> 
>> Here we go:
>> 
>> Let L1 and L2 be two spinlocks.
>> 
>> Let T1 be a task holding L1 and blocked on L2. T1, currently, is the top
>> waiter of L2.
>> 
>> Let T2 be the task holding L2.
>> 
>> Let T3 be a task trying to acquire L1.
>> 
>> The following events will lead to a state in which the wait queue of L2
>> isn't empty but nobody holds it.

That explains it nicely. Care to resend with proper explanations in the
changelog?

Thanks,

        tglx
