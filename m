Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id E665E742C53
	for <lists+linux-kernel@lfdr.de>; Thu, 29 Jun 2023 20:48:23 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232898AbjF2Srz (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 29 Jun 2023 14:47:55 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59738 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232588AbjF2Src (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 29 Jun 2023 14:47:32 -0400
Received: from galois.linutronix.de (Galois.linutronix.de [IPv6:2a0a:51c0:0:12e:550::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2D4473583
        for <linux-kernel@vger.kernel.org>; Thu, 29 Jun 2023 11:47:32 -0700 (PDT)
From:   Thomas Gleixner <tglx@linutronix.de>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020; t=1688064450;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=Y5na3ht2L3FpaEOFqHWRzLsgtpVnZz85aiq3JLJ8S7Q=;
        b=kgUbA3G/3WN7nVCTDdoDfaaAOdeCb5mESQX5W884oOjTJONyT3LIiOK01e1aVbubT4Wb86
        dWUgclTrMHRiJF54DVUHJRMJMLLO6Try8nLbXT0ieKsXlUWbdPz9CAK1cKqevxK8LQsOaz
        Hupw2mb3sGkdzxzvWRcA57brjpkKKr96g62Fff/YGZ1NCR2c6WZ6hVg2KFJXW+9Qh4Emex
        qr8kktdIyo13d90Ap4AVY4ELLuB/aYUglnkvKuDd0dCX5Aam6vC0gi5tmJ+5E+Ys4r/+Jj
        sCT90bSWQM1fAC5Q7SIwBSaayRNJHmvqhKVP5S5tbnx6z4zthjoiaHgp78UD/Q==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020e; t=1688064450;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=Y5na3ht2L3FpaEOFqHWRzLsgtpVnZz85aiq3JLJ8S7Q=;
        b=RvW7ZFL+WHPW6900QzCm9rPhgcol2STJu2mcqpMTQKmqE6J+bMXQOgHkIit7Etc7xVqwGl
        ZL6P5f5CbIpd7oDA==
To:     Frederic Weisbecker <frederic@kernel.org>
Cc:     LKML <linux-kernel@vger.kernel.org>,
        Anna-Maria Behnsen <anna-maria@linutronix.de>,
        John Stultz <jstultz@google.com>,
        Peter Zijlstra <peterz@infradead.org>,
        Ingo Molnar <mingo@kernel.org>,
        Stephen Boyd <sboyd@kernel.org>,
        Eric Biederman <ebiederm@xmission.com>,
        Oleg Nesterov <oleg@redhat.com>
Subject: Re: [patch 14/45] posix-timers: Consolidate interval retrieval
In-Reply-To: <ZJww66Svi84Bvw9Z@localhost.localdomain>
References: <20230606132949.068951363@linutronix.de>
 <20230606142031.816970056@linutronix.de>
 <ZJww66Svi84Bvw9Z@localhost.localdomain>
Date:   Thu, 29 Jun 2023 20:47:30 +0200
Message-ID: <87ttuq14xp.ffs@tglx>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,SPF_HELO_NONE,
        SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Jun 28 2023 at 15:08, Frederic Weisbecker wrote:

> Le Tue, Jun 06, 2023 at 04:37:40PM +0200, Thomas Gleixner a =C3=A9crit :
>> There is no point to collect the current interval in the posix clock
>> specific settime() and gettime() callbacks. Just do it right in the comm=
on
>> code.
>>=20
>> Signed-off-by: Thomas Gleixner <tglx@linutronix.de>
>
> The only difference I see is that we now return the old interval
> even if the target is reaped, which probably doesn't matter anyway.

But we don't return it to user space because ret !=3D 0 in that case.
