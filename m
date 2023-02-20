Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 5725569C947
	for <lists+linux-kernel@lfdr.de>; Mon, 20 Feb 2023 12:09:08 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231452AbjBTLJF (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 20 Feb 2023 06:09:05 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34274 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229479AbjBTLJD (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 20 Feb 2023 06:09:03 -0500
Received: from desiato.infradead.org (desiato.infradead.org [IPv6:2001:8b0:10b:1:d65d:64ff:fe57:4e05])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2E3B5B779
        for <linux-kernel@vger.kernel.org>; Mon, 20 Feb 2023 03:08:47 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=desiato.20200630; h=In-Reply-To:Content-Type:MIME-Version:
        References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
        Content-Transfer-Encoding:Content-ID:Content-Description;
        bh=tkoxDrw8EDDRtnI6iJWRhG5PvCkA9PC/AkIws3Xlkdw=; b=jdFHLHjiFQvmrjBL7zwpLhvuGe
        W8HOSnG2dnD/RGvAk9IEmY3lT97A9W88JJZ4+AsgsnwjCPB+Nck5k2E/K3oFrzwz0y7qz7HZV8w12
        ljtwx8h5Ob10JywR2QAXZMf2ULE/XGySuHZVsjPVTgrc5LAMAggMneG7n+cMhFVv6rNQmAF/1EJUB
        zGFuxd8YuufUie9gTh4rrlLrTwygURKcUGESweM7urDXhQMumN6YaFNs3cZnCctkom7Lxtiv9SKLy
        tNoPkQwnLYavWta/E7jwXMI2PsLTNNI9hYbBJ7CQeiKF8GyPv15QOZucI7FDqBMaMY+363ie9g8Wq
        vIHBdy3w==;
Received: from j130084.upc-j.chello.nl ([24.132.130.84] helo=noisy.programming.kicks-ass.net)
        by desiato.infradead.org with esmtpsa (Exim 4.96 #2 (Red Hat Linux))
        id 1pU41n-00Bmce-1x;
        Mon, 20 Feb 2023 11:08:17 +0000
Received: from hirez.programming.kicks-ass.net (hirez.programming.kicks-ass.net [192.168.1.225])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
        (Client did not present a certificate)
        by noisy.programming.kicks-ass.net (Postfix) with ESMTPS id 4B4B130020B;
        Mon, 20 Feb 2023 12:08:14 +0100 (CET)
Received: by hirez.programming.kicks-ass.net (Postfix, from userid 1000)
        id 2EE4A2135FAB8; Mon, 20 Feb 2023 12:08:14 +0100 (CET)
Date:   Mon, 20 Feb 2023 12:08:14 +0100
From:   Peter Zijlstra <peterz@infradead.org>
To:     Zhang Rui <rui.zhang@intel.com>
Cc:     tglx@linutronix.de, mingo@redhat.com, bp@alien8.de,
        dave.hansen@linux.intel.com, hpa@zytor.com, x86@kernel.org,
        linux-kernel@vger.kernel.org, zhang.jia@linux.alibaba.com,
        len.brown@intel.com
Subject: Re: [RFC PATCH V2 0/1] x86: cpu topology fix and question on
 x86_max_cores
Message-ID: <Y/NUni00nDuURT1H@hirez.programming.kicks-ass.net>
References: <20230220032856.661884-1-rui.zhang@intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20230220032856.661884-1-rui.zhang@intel.com>
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,SPF_HELO_NONE,
        SPF_NONE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Feb 20, 2023 at 11:28:55AM +0800, Zhang Rui wrote:

> Questions on how to fix cpuinfo_x86.x86_max_cores
> -------------------------------------------------
> 
> Fixing x86_max_cores is more complex. Current kernel uses below logic to
> get x86_max_cores
> 	x86_max_cores = cpus_in_a_package / smp_num_siblings
> But
> 1. There is a known bug in CPUID.1F handling code. Thus cpus_in_a_package
>    can be bogus. To fix it, I will add CPUID.1F Module level support.
> 2. x86_max_cores is set and used in an inconsistent way in current kernel.
>    In short, smp_num_siblings/x86_max_cores
>    2.1 represents the number of maximum *addressable* threads/cores in a
>        core/package when retrieved via CPUID 1 and 4 on old platforms.
>        CPUID.1 EBX 23:16 "Maximum number of addressable IDs for logical
>        processors in this physical package".
>        CPUID.4 EAX 31:26 "Maximum number of addressable IDs for processor
>        cores in the physical package".
>    2.2 represents the number of maximum *possible* threads/cores in a
>        core/package, when retrieved via CPUID.B/1F on non-Hybrid platforms.
>        CPUID.B/1F EBX 15:0 "Number of logical processors at this level type.
>        The number reflects configuration as shipped by Intel".
>        For example, in calc_llc_size_per_core()
>           do_div(llc_size, c->x86_max_cores);
>        x86_max_cores is used as the max *possible* cores in a package.
>    2.3 is used in a conflict way on other vendors like AMD by checking the
>        code. I need help on confirming the proper behavior for AMD.
>        For example, in amd_get_topology(),
>           c->x86_coreid_bits = get_count_order(c->x86_max_cores);
>        x86_max_cores is used as the max *addressable* cores in a package.
>        in get_nbc_for_node(),
>           cores_per_node = (c->x86_max_cores * smp_num_siblings) / amd_get_nodes_per_socket();
>        x86_max_cores is used as the max *possible* cores in a package.
> 3. using
>       x86_max_cores = cpus_in_a_package / smp_num_siblings
>    to get the number of maximum *possible* cores in a package during boot
>    cpu bringup is not applicable on platforms with asymmetric cores.
>    Because, for a given number of threads, we don't know how many of the
>    threads are the master thread or the only thread of a core, and how
>    many of them are SMT siblings.
>    For example, on a platform with 6 Pcore and 8 Ecore, there are 20
>    threads. But setting x86_max_cores to 10 is apparently wrong.
> 
> Given the above situation, I have below question and any input is really
> appreciated.
> 
> Is this inconsistency a problem or not?

IIRC x86_max_cores in specific is only ever used in arch specific code,
the pmu uncore drivers and things like that (grep shows MCE).

Also, perhaps you want to look at calculate_max_logical_packages(). That
has a comment about there not being heterogeneous systems :/

Anyway, the reason I went and had a look there, is because I remember
Thomas and me spend entirely too much time to try and figure out means
to size an array for number of pacakges at boot time and getting it
wrong too many times to recount.

If only there was a sane way to tell these things without actually
bringing everything online first :-(
