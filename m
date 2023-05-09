Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 611596FC5C7
	for <lists+linux-kernel@lfdr.de>; Tue,  9 May 2023 14:05:11 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235225AbjEIMFG (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 9 May 2023 08:05:06 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49212 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230060AbjEIMFE (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 9 May 2023 08:05:04 -0400
Received: from galois.linutronix.de (Galois.linutronix.de [193.142.43.55])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6938BFA
        for <linux-kernel@vger.kernel.org>; Tue,  9 May 2023 05:05:02 -0700 (PDT)
From:   Thomas Gleixner <tglx@linutronix.de>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020; t=1683633899;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=Kvqm2dmajpGghQsJDkgZdeiUUB7dpowlCQreLwcp9to=;
        b=VVZ0E+/8SoSfv4iZ+D4UY/S8uRPa8PNRmGzScCW3B1dN4WTFuQpFIG0/UVHxs5oqS1tLp/
        leDeEFFUHOSY4ZgOKFhHqxxrHF3ANx8gfGZ0khykCcmgDRuxm8DeSF/GQLjWY2Jgt6qV52
        VMfxHjhFAIuDV0CHNJAY4Q2CBv4N8fYckwYWBLdXSQSgPJndUsbG8Ds8TY8qZUhtr7Zyke
        QsclPJaHZrqYeMXGzYso+RIYIGbUnqF+hqe9iOwJroaluqZN2AVWtN9AdYiieLYXSk5hUa
        BEOxq3h6yPcGKVGLfygrKBazIVkvp4xbfsQGjs61cHy5WK+EN5ruLKaqrU/nYQ==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020e; t=1683633899;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=Kvqm2dmajpGghQsJDkgZdeiUUB7dpowlCQreLwcp9to=;
        b=f+6K7frA+UDBc42P9UhYbr/DfRkzov8/muWaoE+mbTtIn3fz2Tq4EfTp8Fk0mp7emBl+zT
        wyhNkTYqKC0CkdAQ==
To:     Frederic Weisbecker <frederic@kernel.org>
Cc:     LKML <linux-kernel@vger.kernel.org>,
        Anna-Maria Behnsen <anna-maria@linutronix.de>,
        Peter Zijlstra <peterz@infradead.org>,
        syzbot+5c54bd3eb218bb595aa9@syzkaller.appspotmail.com,
        Dmitry Vyukov <dvyukov@google.com>,
        Sebastian Siewior <bigeasy@linutronix.de>,
        Michael Kerrisk <mtk.manpages@gmail.com>
Subject: Re: [patch 02/20] posix-timers: Ensure timer ID search-loop limit
 is valid
In-Reply-To: <ZFoVg9UmItpIaA69@lothringen>
References: <20230425181827.219128101@linutronix.de>
 <20230425183312.932345089@linutronix.de> <ZFUXrCZtWyNG3Esi@lothringen>
 <87zg6i2xn3.ffs@tglx> <87v8h62vwp.ffs@tglx> <ZFoVg9UmItpIaA69@lothringen>
Date:   Tue, 09 May 2023 14:04:59 +0200
Message-ID: <87sfc51zis.ffs@tglx>
MIME-Version: 1.0
Content-Type: text/plain
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,SPF_HELO_NONE,
        SPF_PASS,T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, May 09 2023 at 11:42, Frederic Weisbecker wrote:
> On Sat, May 06, 2023 at 01:36:22AM +0200, Thomas Gleixner wrote:
>> That would avoid the hash table lookups and the related issues, but OTH
>> it would require to allocate one extra page per TGID if the application
>> uses a single posix timer.
>> 
>> Not sure whether that's worth it though.
>
> Not sure either...

See my other reply on that...
