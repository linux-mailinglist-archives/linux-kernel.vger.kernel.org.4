Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 97CD160FA94
	for <lists+linux-kernel@lfdr.de>; Thu, 27 Oct 2022 16:39:57 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235362AbiJ0Oj4 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 27 Oct 2022 10:39:56 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47160 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235489AbiJ0Ojw (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 27 Oct 2022 10:39:52 -0400
Received: from galois.linutronix.de (Galois.linutronix.de [IPv6:2a0a:51c0:0:12e:550::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id ED42F58525;
        Thu, 27 Oct 2022 07:39:51 -0700 (PDT)
From:   John Ogness <john.ogness@linutronix.de>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020; t=1666881588;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=jbxARsfRC6v5A83uXW6hh52ECqe0nM8Oe/dP4o5OVDQ=;
        b=GRt8WmOOYTVQYQdbVvUO9ozbKobBIHsAqnsxffGe0aRtNiCGayoW0HpSWWOur4SwiLVKq0
        WDvOhVKRp9+oBG7ma8og9hKAK97tI6S0rJZEG0xjyj6KKsAyEl/nQZbMSSMSTU1NkB3C7O
        SSfDlaakqotzDdEQwyRYjdHRzH+4/L5k0dzEDBKAMUSmPJOJasznQX/VTXNh+asURWOxkX
        m3bzyXH28+zubtQ3JJEIWGp8MkCT64bnonogoy5WzYE3E++MEPjsYP36tN1/cIABHJzV3Z
        qwVKYvUBwBD3Px2ZeRyiONVLeW1eSXRHJM95fUoHsBYzW2OHkpDc6K51STgudw==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020e; t=1666881588;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=jbxARsfRC6v5A83uXW6hh52ECqe0nM8Oe/dP4o5OVDQ=;
        b=RRC4iqdInwglcGXrHzMsTN+Tp1Aj4twNF78GnyK14oGdgK5t4Wlzn/4bprc5cM+75jPget
        TrVUU0ytp+519qAg==
To:     paulmck@kernel.org
Cc:     Frederic Weisbecker <frederic@kernel.org>, rcu@vger.kernel.org,
        linux-kernel@vger.kernel.org, kernel-team@fb.com,
        rostedt@goodmis.org, tglx@linutronix.de, pmladek@suse.com
Subject: Re: [PATCH v2 rcu 0/8] NMI-safe SRCU reader API
In-Reply-To: <20221027141045.GX5600@paulmck-ThinkPad-P17-Gen-1>
References: <20221018215721.GA1716567@paulmck-ThinkPad-P17-Gen-1>
 <87pmeoawwe.fsf@jogness.linutronix.de>
 <20221019191418.GF5600@paulmck-ThinkPad-P17-Gen-1>
 <20221019220537.GA1234896@lothringen>
 <20221020222718.GA5600@paulmck-ThinkPad-P17-Gen-1>
 <87r0z1gy51.fsf@jogness.linutronix.de>
 <20221021184152.GO5600@paulmck-ThinkPad-P17-Gen-1>
 <87y1t5zqzz.fsf@jogness.linutronix.de>
 <20221024134727.GV5600@paulmck-ThinkPad-P17-Gen-1>
 <874jvpehod.fsf@jogness.linutronix.de>
 <20221027141045.GX5600@paulmck-ThinkPad-P17-Gen-1>
Date:   Thu, 27 Oct 2022 16:45:47 +0206
Message-ID: <87sfj9couk.fsf@jogness.linutronix.de>
MIME-Version: 1.0
Content-Type: text/plain
X-Spam-Status: No, score=-3.9 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,INVALID_DATE_TZ_ABSURD,
        RCVD_IN_DNSWL_MED,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 2022-10-27, "Paul E. McKenney" <paulmck@kernel.org> wrote:
> The warning is claiming that this srcu_struct was passed to
> srcu_read_lock() at some point and is now being passed to
> srcu_read_lock_nmisafe().

Indeed, I found some code that was not using my wrappers. Thanks. Living
proof that it was a good idea to add the checks. ;-)

John
