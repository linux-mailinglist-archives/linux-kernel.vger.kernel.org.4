Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 3BC8A6076DF
	for <lists+linux-kernel@lfdr.de>; Fri, 21 Oct 2022 14:27:31 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229889AbiJUM12 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 21 Oct 2022 08:27:28 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41956 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229711AbiJUM10 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 21 Oct 2022 08:27:26 -0400
Received: from galois.linutronix.de (Galois.linutronix.de [193.142.43.55])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7C1CD25FD03;
        Fri, 21 Oct 2022 05:27:25 -0700 (PDT)
From:   John Ogness <john.ogness@linutronix.de>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020; t=1666355243;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=S6dTb60kjmg47ocoU6HZ3Jj5gJEz3YIhFuigbVZaNJM=;
        b=n6FmS0/4dWhc8jTwfYQRD0Ikece68bOOrCIaYj2rN70DFlrOp6fc4cOFJD1q4ouO6Refoa
        w/JMiTJHmpf1zI94fm+G7VrwUzw5h9GMS5Kgx8yXeykpMeRgkLJz9ab423Ii5uHHguY8lH
        TZSoXoul5SVlfjLlms+iSxF3SZiDAAG8jYxnDs8jR3/eV6mJZgubawZTNTo4e4oNoPC/zU
        1HZerjR/dEP0ODDE+FhAfxIgHBjCTEPKfGpZP+eKNvvj5z2IPCbDpqCbA2GcUW+763YNSr
        yM2tczO2iUnsKQ/0YIv9Njw9hV6K06KdCOEl0a4Gr3twWxADQ/l9vwHtpSCn0w==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020e; t=1666355243;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=S6dTb60kjmg47ocoU6HZ3Jj5gJEz3YIhFuigbVZaNJM=;
        b=T2PPwc0trid0JhblC1dEpVLV6LIudIng+ZTZ9MMbJVF4ZEnfVvonRAfpvTuJWFygg4jy09
        1iylHMK5Se6IlZCQ==
To:     paulmck@kernel.org, Frederic Weisbecker <frederic@kernel.org>
Cc:     rcu@vger.kernel.org, linux-kernel@vger.kernel.org,
        kernel-team@fb.com, rostedt@goodmis.org, tglx@linutronix.de,
        pmladek@suse.com
Subject: Re: [PATCH v2 rcu 0/8] NMI-safe SRCU reader API
In-Reply-To: <20221020222718.GA5600@paulmck-ThinkPad-P17-Gen-1>
References: <20220921144620.GA1200846@paulmck-ThinkPad-P17-Gen-1>
 <20220929180714.GA2874192@paulmck-ThinkPad-P17-Gen-1>
 <87k04x4e0r.fsf@jogness.linutronix.de>
 <20221018152418.GR5600@paulmck-ThinkPad-P17-Gen-1>
 <87ilkh0y52.fsf@jogness.linutronix.de>
 <20221018185936.GX5600@paulmck-ThinkPad-P17-Gen-1>
 <20221018215721.GA1716567@paulmck-ThinkPad-P17-Gen-1>
 <87pmeoawwe.fsf@jogness.linutronix.de>
 <20221019191418.GF5600@paulmck-ThinkPad-P17-Gen-1>
 <20221019220537.GA1234896@lothringen>
 <20221020222718.GA5600@paulmck-ThinkPad-P17-Gen-1>
Date:   Fri, 21 Oct 2022 14:33:22 +0206
Message-ID: <87r0z1gy51.fsf@jogness.linutronix.de>
MIME-Version: 1.0
Content-Type: text/plain
X-Spam-Status: No, score=-3.9 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,INVALID_DATE_TZ_ABSURD,
        RCVD_IN_DNSWL_MED,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 2022-10-20, "Paul E. McKenney" <paulmck@kernel.org> wrote:
> I have an untested but allegedly fixed branch on -rcu on branch
> srcunmisafe.2022.10.20a.

FWIW, my C-I build system was happy with srcunmisafe.2022.10.20a.

John
