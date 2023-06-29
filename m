Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id A937E742827
	for <lists+linux-kernel@lfdr.de>; Thu, 29 Jun 2023 16:19:18 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231855AbjF2OTL (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 29 Jun 2023 10:19:11 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57240 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231952AbjF2OTB (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 29 Jun 2023 10:19:01 -0400
Received: from galois.linutronix.de (Galois.linutronix.de [193.142.43.55])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9615035A9;
        Thu, 29 Jun 2023 07:19:00 -0700 (PDT)
From:   Thomas Gleixner <tglx@linutronix.de>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020; t=1688048338;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=tcsyILS54G9Ylc5jhOd6kkhT9PsNGi7DVVNg0xcX1kQ=;
        b=UCd+zetdFtrupJKCxOImcOxEEYVwTwTvmkKbn8hKvfSyKXqMbmVcR1zCTJi+G+RViUHK4E
        Y9q0thPUWYdOXqChC/StMKF2R2w4nD0hiz4xNKzNr4M2EtQ9NRRA8SVB5G9U9ACtk2xCsc
        PPQzJRvOsyumV/NC0gxfmVzaLNrKIl7HMEum0BbZMP+z4ACCuvbpH/8tFtYyphMuz/I3Ef
        hJOKYUpeUcjpNpPvaR1IqKCZ8GNIwkjTdsfwv/jJzLmQWNviBAypnN++2aPu2bzOejUv2m
        s7vhMr6wZ13FsN0P7As3VIpwdBaOvI+TTGMvDuwJnHlIM4s5ANGzLA0w1l5wwg==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020e; t=1688048338;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=tcsyILS54G9Ylc5jhOd6kkhT9PsNGi7DVVNg0xcX1kQ=;
        b=eVh4xcwU+ECp7+of3b7renU0kjswNCBP4itYsa/RB7p1Pb1FjkVIcc8e0ibcsLlhES1S79
        66vXMUDddUHapCCQ==
To:     Vivek Anand <vivekanand754@gmail.com>,
        Peter Zijlstra <peterz@infradead.org>
Cc:     Bagas Sanjaya <bagasdotme@gmail.com>,
        "Steven Rostedt (Google)" <rostedt@goodmis.org>,
        Pablo Neira Ayuso <pablo@netfilter.org>,
        Jozsef Kadlecsik <kadlec@netfilter.org>,
        Florian Westphal <fw@strlen.de>,
        "David S. Miller" <davem@davemloft.net>,
        Eric Dumazet <edumazet@google.com>,
        Jakub Kicinski <kuba@kernel.org>,
        Paolo Abeni <pabeni@redhat.com>,
        Lingutla Chandrasekhar <clingutla@codeaurora.org>,
        Frederic Weisbecker <frederic@kernel.org>,
        "J. Avila" <elavila@google.com>,
        "Rafael J. Wysocki" <rafael@kernel.org>,
        Thomas Renninger <trenn@suse.com>,
        Shuah Khan <shuah@kernel.org>, Borislav Petkov <bp@alien8.de>,
        Josh Poimboeuf <jpoimboe@kernel.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Linux Regressions <regressions@lists.linux.dev>,
        Linux Netfilter Development <netfilter-devel@vger.kernel.org>,
        Netfilter Core Developers <coreteam@netfilter.org>,
        Linux Networking <netdev@vger.kernel.org>,
        Linux Power Management <linux-pm@vger.kernel.org>,
        x86@kernel.org
Subject: Re: Fwd: High cpu usage caused by kernel process when upgraded to
 linux 5.19.17 or later
In-Reply-To: <CAJnqnX5rYn65zVQ+SLN4m4ZzM_jOa_RjGhazWO=Fh8ZvdOCadg@mail.gmail.com>
References: <01ac399d-f793-49d4-844b-72cd8e0034df@gmail.com>
 <ZJpJkL3dPXxgw6RK@debian.me>
 <20230627073035.GV4253@hirez.programming.kicks-ass.net>
 <99b64dfd-be4a-2248-5c42-8eb9197824e1@gmail.com>
 <20230627101939.GZ4253@hirez.programming.kicks-ass.net>
 <CAJnqnX5rYn65zVQ+SLN4m4ZzM_jOa_RjGhazWO=Fh8ZvdOCadg@mail.gmail.com>
Date:   Thu, 29 Jun 2023 16:18:57 +0200
Message-ID: <878rc22vxq.ffs@tglx>
MIME-Version: 1.0
Content-Type: text/plain
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,SPF_HELO_NONE,
        SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Jun 29 2023 at 12:05, Vivek Anand wrote:
> I've tried booting with "spectre_v2=retpoline retbleed=off".
> This change didn't work. Still CPU is 100%

This does not make sense.

retbleed=off has the same effect as CONFIG_X86_IBRS_ENTRY=n.

The only difference is that with CONFIG_X86_IBRS_ENTRY=y and
retbleed=off there is one extra jump in the low level entry code
(syscall, interrupts, exceptions) and one extra jump on the exit side.

But those extra jumps are completely irrelevant for the kworker threads.

Can you please provide dmesg and the content of the files in

 /sys/devices/system/cpu/vulnerabilities/

on a kernel booted with "spectre_v2=retpoline retbleed=off" ?

Thanks,

        tglx
