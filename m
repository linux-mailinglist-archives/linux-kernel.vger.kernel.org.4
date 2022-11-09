Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 382116235A0
	for <lists+linux-kernel@lfdr.de>; Wed,  9 Nov 2022 22:17:46 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231648AbiKIVRo (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 9 Nov 2022 16:17:44 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36634 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229452AbiKIVRm (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 9 Nov 2022 16:17:42 -0500
Received: from bombadil.infradead.org (bombadil.infradead.org [IPv6:2607:7c80:54:3::133])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B3A5431221;
        Wed,  9 Nov 2022 13:17:41 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=bombadil.20210309; h=Sender:In-Reply-To:Content-Type:
        MIME-Version:References:Message-ID:Subject:Cc:To:From:Date:Reply-To:
        Content-Transfer-Encoding:Content-ID:Content-Description;
        bh=c2Wy125HjX2W7gqEInmUWaHL+2Vak7X60gZ/uKVxsSs=; b=yTyMtQVIIuXac7UW27SjuG9FjG
        FaNaEfZ1TQyT856V2r9PHoNMTj1OFga3j6sCeGL5vpTaladSMUcaUqlEh7FhPpGzmcgViQIE+XamI
        57plJW0OSYsmvdILQmQY1Q/fNcPb2WEGHDp6RnEVFTvXds//du5ABC2lJNjVOqyXX1A704rNcdiHM
        aHhVDPBY7FMDBohK5yGY1VIjFtEWemGGKAC1JVcG84zgDMzQiZempRpkBc4NYYMUhbJvIIxVGGvfi
        XKzZ06LfYfF7ex2aqalbXQBI14ZikP4rfNEIAEAQmmt1pv0oSTTKxu6qp2CS1l45ct8nuw+AyhJWK
        KjxiEKAg==;
Received: from mcgrof by bombadil.infradead.org with local (Exim 4.94.2 #2 (Red Hat Linux))
        id 1ossRG-00HMpa-89; Wed, 09 Nov 2022 21:16:50 +0000
Date:   Wed, 9 Nov 2022 13:16:50 -0800
From:   Luis Chamberlain <mcgrof@kernel.org>
To:     Kees Cook <keescook@chromium.org>
Cc:     Jann Horn <jannh@google.com>, Greg KH <gregkh@linuxfoundation.org>,
        Linus Torvalds <torvalds@linuxfoundation.org>,
        Seth Jenkins <sethjenkins@google.com>,
        Andy Lutomirski <luto@kernel.org>,
        Petr Mladek <pmladek@suse.com>,
        Andrew Morton <akpm@linux-foundation.org>,
        tangmeng <tangmeng@uniontech.com>,
        "Guilherme G. Piccoli" <gpiccoli@igalia.com>,
        Tiezhu Yang <yangtiezhu@loongson.cn>,
        Sebastian Andrzej Siewior <bigeasy@linutronix.de>,
        "Eric W. Biederman" <ebiederm@xmission.com>,
        Arnd Bergmann <arnd@arndb.de>, Marco Elver <elver@google.com>,
        Dmitry Vyukov <dvyukov@google.com>,
        Peter Zijlstra <peterz@infradead.org>,
        Juri Lelli <juri.lelli@redhat.com>,
        Vincent Guittot <vincent.guittot@linaro.org>,
        Dietmar Eggemann <dietmar.eggemann@arm.com>,
        Steven Rostedt <rostedt@goodmis.org>,
        Ben Segall <bsegall@google.com>, Mel Gorman <mgorman@suse.de>,
        Daniel Bristot de Oliveira <bristot@redhat.com>,
        Valentin Schneider <vschneid@redhat.com>,
        Andrey Ryabinin <ryabinin.a.a@gmail.com>,
        Alexander Potapenko <glider@google.com>,
        Andrey Konovalov <andreyknvl@gmail.com>,
        Vincenzo Frascino <vincenzo.frascino@arm.com>,
        David Gow <davidgow@google.com>,
        "Paul E. McKenney" <paulmck@kernel.org>,
        Jonathan Corbet <corbet@lwn.net>,
        Baolin Wang <baolin.wang@linux.alibaba.com>,
        "Jason A. Donenfeld" <Jason@zx2c4.com>,
        Eric Biggers <ebiggers@google.com>,
        Huang Ying <ying.huang@intel.com>,
        Anton Vorontsov <anton@enomsg.org>,
        Mauro Carvalho Chehab <mchehab+huawei@kernel.org>,
        Laurent Dufour <ldufour@linux.ibm.com>,
        Rob Herring <robh@kernel.org>, linux-kernel@vger.kernel.org,
        kasan-dev@googlegroups.com, linux-mm@kvack.org,
        linux-doc@vger.kernel.org, linux-hardening@vger.kernel.org
Subject: Re: [PATCH next v2 0/6] exit: Put an upper limit on how often we can
 oops
Message-ID: <Y2wYwsolgpRGPuMK@bombadil.infradead.org>
References: <20221109194404.gonna.558-kees@kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20221109194404.gonna.558-kees@kernel.org>
Sender: Luis Chamberlain <mcgrof@infradead.org>
X-Spam-Status: No, score=-4.0 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_EF,HEADER_FROM_DIFFERENT_DOMAINS,
        RCVD_IN_DNSWL_MED,SPF_HELO_NONE,SPF_NONE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Nov 09, 2022 at 12:00:43PM -0800, Kees Cook wrote:
> Hi,
> 
> This builds on Jann's v1 patch[1]. Changes in v2:
> - move sysctl into kernel/exit.c (where it belongs)
> - expand Documentation slightly
> 
> New stuff in v2:
> - expose oops_count to sysfs
> - consolidate panic_on_warn usage
> - introduce warn_limit
> - expose warn_count to sysfs
> 
> [1] https://lore.kernel.org/lkml/20221107201317.324457-1-jannh@google.com
> 
> Jann Horn (1):
>   exit: Put an upper limit on how often we can oops
> 
> Kees Cook (5):
>   panic: Separate sysctl logic from CONFIG_SMP
>   exit: Expose "oops_count" to sysfs
>   panic: Consolidate open-coded panic_on_warn checks
>   panic: Introduce warn_limit
>   panic: Expose "warn_count" to sysfs

For all:

Reviewed-by: Luis Chamberlain <mcgrof@kernel.org>

  Luis
